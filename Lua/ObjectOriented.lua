function class(super)
    local class_type = {}
    class_type.ctor = false
    class_type.super = super
    class_type.new = function(...)
        local obj = {}
        do
            local create = function(c, ...)
                if c.super then        
                    create(c.super, ...)
                end
                if c.ctor then
                    c.ctor(obj, ...)
                end
            end
            create(class_type,...)
        end
        setmetatable(obj, {__index = class_type})
        return obj
    end

    if super then
        setmetatable(class_type, {__index = 
            function(t,k)
                local ret = super[k]
                return ret
            end
        })
    end
    return class_type
end
