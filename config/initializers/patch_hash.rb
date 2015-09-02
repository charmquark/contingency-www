class Hash
    
    def deep_union(other_hash, preserve = false)
        self.dup.merge! other_hash
    end
    
    
    def deep_union!(other_hash, preserve = false)
        self.merge!(other_hash) do |key, oldval, newval|
            if oldval.is_a? Array then
                if newval.is_a? Array then
                    oldval | newval
                else
                    (oldval << newval).uniq
                end
            elsif newval.is_a? Array then
                (newval.dup << oldval).uniq
            elsif oldval.is_a?(Hash) and newval.is_a?(Hash) then
                oldval.deep_union newval, preserve
            else
                preserve ? oldval : newval
            end
        end
    end
    
    
    def union(other_hash, preserve = false)
        self.dup.merge! other_hash, preserve
    end
    
    
    def union!(other_hash, preserve = false)
        self.merge!(other_hash) do |key, oldval, newval|
            if oldval.is_a? Array then
                if newval.is_a? Array then
                    oldval | newval
                else
                    (oldval << newval).uniq
                end
            elsif newval.is_a? Array then
                (newval.dup << oldval).uniq
            else
                preserve ? oldval : newval
            end
        end
    end
    
end