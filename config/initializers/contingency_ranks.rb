module ContingencyRanks

    class Rank
        
        def initialize(r_name, r_sym, r_val)
            @name = r_name
            @symbol = r_sym
            @value = r_val
        end
        
        attr_reader :name, :symbol, :value
        
        
        def <=>(other)
            other = other.to_sym if other.is_a? String
            other = RANKS_BY_SYMBOL[other] if other.is_a? Symbol
            return nil unless other.is_a? Rank
            other.value <=> @value
        end
        
    end
    
    
    RANKS = [   #name         symbol      value
        Rank.new('Core'     , :core     , 100   ),
        Rank.new('General'  , :general  , 50    )
    ].sort

    
    def self.generate_ranks_by_symbol
        result = {}
        RANKS.each do |rank|
            result[rank.symbol] = rank
        end
        result
    end
    RANKS_BY_SYMBOL = generate_ranks_by_symbol
    
    
    def self.from_sym(r_sym)
        RANKS_BY_SYMBOL[r_sym.to_sym]
    end
    
    
    def self.valid?(rank)
        return true if rank.is_a? Rank
        ! from_sym(rank).nil?
    end

end