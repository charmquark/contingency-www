class ApplicationMailer < ActionMailer::Base
    default from: 'noreply@thecontingency.org'
    layout 'mailer'
    
    
private


    def common_options(subject)
        result = {
            subject: subject,
            to: member_address(@member)
        }
        result.union! cc: member_address(@admin) if @admin.email?
        result
    end


    def member_address(m)
        if Rails.env.production? then
            "#{m.handle} <#{m.email}>"
        else
            "#{m.handle} <ibisbasenji@gmail.com>"
        end
    end
end
