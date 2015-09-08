class MemberMailer < ApplicationMailer
    def new_member(admin, member)
        if member.email? then
            @admin = admin
            @member = member
            mail common_options('Welcome to The Contingency')
        end
    end
    
    
    def edit_member(admin, member)
        if member.email? && admin != member then
            @admin = admin
            @member = member
            mail common_options('Your Contingency Profile was Updated')
        end
    end
end
