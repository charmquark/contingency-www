module CacheHelper
    def action_cache_tag
        "#{controller_name}-#{action_name}/"
    end
    
    def model_cache(model, tag = nil, &blk)
        cache model_cache_key(model, tag), &blk
    end
    
    def model_cache_key(model, tag = nil)
        tag ||= action_cache_tag
        "#{tag}#{model.model_name.route_key}/all-#{model.count}-#{timestamp_to_s model.maximum(:updated_at)}"
    end
    
    def model_cache_unless(condition, model, tag = nil, &blk)
        unless condition then
            model_cache model, tag, &blk
        else
            yield
        end
    end
    
    def record_cache(rec, tag = nil, &blk)
        cache record_cache_key(rec, tag), &blk
    end
    
    def record_cache_key(rec, tag = nil)
        tag ||= action_cache_tag
        "#{tag}#{rec.model_name.route_key}/#{rec.id}-#{timestamp_to_s rec.updated_at}"
    end

    def record_cache_unless(condition, rec, tag = nil, &blk)
        unless condition then
            record_cache rec, tag, &blk
        else
            yield
        end
    end
    
    def timestamp_to_s(stamp)
        stamp.try(:utc).try(:to_s, :number)
    end
end