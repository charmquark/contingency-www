module ContingencyRoles
    
    class Role
        
        def initialize(r_name, r_sym)
            @name = r_name
            @symbol = r_sym
        end
        
        attr_reader :name, :symbol
        
    end
    
    
    ROLES = [   #name                 symbol
        Role.new('User'             , :user     ),
        Role.new('Administrator'    , :admin    )
    ]
    
    
    def self.generate_roles_by_symbol
        result = {}
        ROLES.each do |role|
            result[role.symbol] = role
        end
        result
    end
    ROLES_BY_SYMBOL = generate_roles_by_symbol
    
    
    def self.from_sym(r_sym)
        ROLES_BY_SYMBOL[r_sym.to_sym]
    end
    
    
    def self.valid?(role)
        return true if role.is_a? Role
        ! from_sym(role).nil?
    end
    
end
