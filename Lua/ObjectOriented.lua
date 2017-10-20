function class(super)
    local class_type = {}
    class_type.ctor = false
    class_type.super = super
    class_type.new = function(...)
        local obj = {class = class_type}
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
        setmetatable(obj, {
            __index = function(t,k)
                if k == "ctor" or k == "super" or k == "new" then
                    return nil
                local ret = class_type[k]
                return ret
            end
        })
        return obj
    end

    if super then
        setmetatable(class_type, {__index = class_type.super})
    end
    return class_type
end
