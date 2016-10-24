require 'rails_helper'

describe Issue, type: :model do
    
    it "has_many articles" do
        issue = Issue.create(:title => "title", :volume => 1, :issue_number => 2, :date => 20161023)
        article = Article.create(:title => "title_a", :order_number => 1, :image_url => "xxx.xxx", :content => "aaabbcc", :issue_id => issue.id)
        expect(issue.articles).to include(article)
    end
end