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
    
    it "#show" do
        get :show, id: @issue_2[:id]
        expect(response).to have_http_status(200)
        expect(response).to render_template(:show)
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
    
    describe "#update" do
        before(:all) do
            @issue_params = {title: "title_1",volume: 1,issue_number: 2,date: 20161023}
        end
        
        it "update issue" do
            put :update,  id: @issue_1[:id], issue: @issue_params
            expect(Issue.find(@issue_1[:id])[:volume]).to eq(1)
        end
    end
    
    describe "#destroy" do
        before(:each) do
            @issue_3 = @issue_2 || Issue.create(title: "title_3", volume: 2,issue_number: 4,date: 20161024)
        end

        it "destroy issue" do
            expect{ delete :destroy, id: @issue_3[:id] }.to change{Issue.all.count}.by(-1)
        end 

        it "redirect_to index after destroy" do
            delete :destroy, id: @issue_3[:id]
            expect(response).to have_http_status(302)
            expect(response).to redirect_to(issues_path)
        end
    end
    
    describe "#generate" do
        before(:all) do
           @issue_1.articles.build({:title => "article_1", :order_number => 1, :image_url => "image.png", :content => "Content Content Content"})
           @issue_1.save!
        end
        
        it "generate html" do  
            get :generate, id: @issue_1[:id]
            
            expect(assigns(:email_html).text).to match(/<html>/)
        end
        
        it "render generate page" do
            get :generate, id: @issue_1[:id]
            
            expect(response).to have_http_status(200)
            expect(response).to render_template(:generate)
        end
    end
end