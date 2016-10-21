class ArticlesController < ApplicationController
    
    def article_params
        params.require(:article).permit(:title, :order_number, :image_url, :content)
    end
    
    def index
        
    end
    
    def new
        
    end
    
    def show
        @issue = Issue.find(params[:issue_id])
        @article = Article.find(params[:id])
    end
    
    def edit
        @issue = Issue.find(params[:issue_id])
        @article = Article.find(params[:id])
    end
    
    def create
        @article = Issue.find(params[:issue_id]).articles.build(article_params)
        @article.save!
        flash[:notice] = "#{@article.title} was successfully created."
        redirect_to issue_path(params[:issue_id]) 
    end
    
    def update
        @article = Article.find(params[:id])
        @article.update_attributes!(article_params)
        flash[:notice] = "#{@article.title} was successfully updated."
        redirect_to issue_article_path(params[:issue_id], params[:id])
    end
    
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        flash[:notice] = "Article '#{@article.title}' deleted."
        redirect_to issue_path(params[:issue_id]) 
    end
    
end
