require 'rails_helper'

describe ArticlesController do
    
    before(:all) do
        @issue_1 = Issue.create(title: "title_1",volume: 1,issue_number: 2,date: 20161023)
        @article_1 = Article.create(:title => "title_1", :order_number => 1, :image_url => "xxx.xxx", :content => "aaabbcc", :issue_id => @issue_1.id)
    end
    
    it "#index" do
		get :index, issue_id: @issue_1[:id]
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
    end
    
    describe "#new" do
        before(:all) do
            @issue_params = {title: "title_1",volume: 1,issue_number: 2,date: 20161023, issue_id: 1}
        end
        
        it "new article" do
            get :new,  issue_id: @issue_1[:id]
            expect(Issue.find(@issue_1.id).articles.find(@article_1.id)[:title]).to eq("title_1")
            expect(response).to have_http_status(200)
            expect(response).to render_template(:new)
        end
    end
    
    it "#show" do
        get :show, issue_id: @issue_1[:id], id: @article_1[:id]
        expect(response).to render_template(:show)
    end
    
    it "#edit" do
        get :edit, issue_id: @issue_1[:id], id: @article_1[:id]
        expect(response).to render_template(:edit)
    end
    
    describe "#update" do
        before(:all) do
            @article_backup = {:title => @article_1.title, :order_number => @article_1.order_number, :image_url => @article_1.image_url, :content => @article_1.content, :issue_id => @article_1.issue_id}
            @article_params = {:title => "title_1", :order_number => 1, :image_url => "xxx.xxx", :content => "changed", :issue_id => @issue_1.id}
        end
        
        it "update article" do
            put :update,  issue_id: @issue_1[:id], id: @article_1[:id], article: @article_params
            expect(Article.find(@article_1[:id])[:content]).to eq(@article_params[:content])
        end
        
        it "restore article" do
            put :update,  issue_id: @issue_1[:id], id: @article_1[:id], article: @article_backup
            expect(Article.find(@article_1[:id])[:content]).to eq(@article_backup[:content])
        end
    end
    
    describe "#destroy" do
        before(:each) do
            @issue_1 = Issue.create(title: "title_1",volume: 1,issue_number: 2,date: 20161023)
            @article_3 = @article_2 || Article.create(:title => "title_1", :order_number => 1, :image_url => "xxx.xxx", :content => "aaabbcc", :issue_id => @issue_1.id)
        end

        it "destroy article" do
            expect{ delete :destroy, issue_id: @issue_1[:id] ,id: @article_3[:id]}.to change{Issue.find(@issue_1.id).articles.all.count}.by(-1)
        end 

        it "redirect_to index after destroy" do
            delete :destroy, issue_id: @issue_1[:id], id: @article_3[:id]
            expect(response).to have_http_status(302)
            expect(response).to redirect_to(issue_path(@article_3[:issue_id]))
        end
    end
    
    describe "#create" do
        before(:all) do
            @article_params = {:title => "title_1", :order_number => 1, :image_url => "xxx.xxx", :content => "changed", :issue_id => @issue_1.id}
        end
        
        it "create issue" do
          expect{ post :create, article: @article_params, issue_id: @issue_1[:id]}.to change{Article.all.size}.by(1)
        end
    end  
    
end