module ApplicationHelper

    def render_error(arg)
        render :json => { :errors => arg.errors.full_messages }
    end
    
    def render_object(arg)
        render :json => { object: arg }
    end
    
    def render_no_content
        render :json => { status: :no_content }
    end
    
    def render_not_present
        render :json => { report: "Record not present in database!" }
    end
    
    def render_id(arg)
        render :json => { id: arg.id }
    end
end
