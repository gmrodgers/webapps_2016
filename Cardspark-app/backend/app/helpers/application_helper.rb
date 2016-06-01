module ApplicationHelper

    def render_error(arg)
        render :json => { :errors => arg.errors.full_messages }
    end
    
    def render_instance(arg)
        render :json => arg, status: :no_content
    end
end
