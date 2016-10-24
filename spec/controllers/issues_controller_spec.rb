require 'rails_helper'

describe IssuesController do
		before(:all) do
        @issue_1 = Issue.create(title: "title_1",volume: 1,issue_number: 2,date: 20161023)
        @issue_2 = Issue.create(title: "title_2",volume: 1,issue_number: 3,date: 20161022)
    end

		
		it "test index instance method" do
		    get :index    
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
    end
    
    it "test new instance method" do
        get :new
        expect(response).to have_http_status(200)
        expect(response).to render_template(:new)
    end
    
    it "test edit instance method" do
        get :edit, id: @issue_1[:id]
        expect(response).to have_http_status(200)
        expect(response).to render_template(:edit)
    end
    
    describe "#create" do
        before(:all) do
            @issue_params = {title: "title",volume: 1,issue_number: 2,date: 20161023}
        end
        
        it "create issue" do
          expect{ post :create, issue: @issue_params}.to change{Issue.all.size}.by(1)
        end
    end  
end