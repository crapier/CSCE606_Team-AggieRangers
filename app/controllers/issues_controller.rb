class IssuesController < ApplicationController
    
    def issue_params
        params.require(:issue).permit(:title, :volume, :issue_number, :date)
    end
    
    def index
         @issues = Issue.all
    end
    
    def new
        
    end
    
    def show
       @issue = Issue.find(params[:id])
       @articles = @issue.articles.order(:order_number => :asc)
    end
    
    
    def edit
        @issue = Issue.find(params[:id])
    end
    
    def create
        @issue = Issue.create!(issue_params)
        flash[:notice] = "#{@issue.title} was successfully created."
        redirect_to issues_path 
    end
    
    def update
        @issue = Issue.find(params[:id])
        @issue.update_attributes!(issue_params)
        flash[:notice] = "#{@issue.title} was successfully updated."
        redirect_to issue_path(params[:id])
    end
    
    def destroy
        @issue = Issue.find(params[:id])
        @issue.destroy
        flash[:notice] = "Issue '#{@issue.title}' deleted."
        redirect_to issues_path
    end
    
end
