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
        __index = function(t,k)
            if k == "ctor" or k == "super" or k == "new" then
                return nil
            local ret = class_type[k]
                return ret
        end
        setmetatable(obj, obj)
        return obj
    end

    if super then
        class_type.__index = class_type.super
        setmetatable(class_type, class_type)
    end
    return class_type
end
