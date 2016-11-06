require 'htmlentities'

class EmailHTML
   attr_accessor :text 
   
    def initialize(initial_text)  
        @text = initial_text
    end
    
    def addline(line)
        @text += line + "\n"
    end
end

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
        flash[:success] = "Issue '#{@issue.title}' was successfully created."
        redirect_to issues_path 
    end
    
    def update
        @issue = Issue.find(params[:id])
        @issue.update_attributes!(issue_params)
        flash[:success] = "Issue '#{@issue.title}' was successfully updated."
        redirect_to issue_path(params[:id])
    end
    
    def destroy
        @issue = Issue.find(params[:id])
        @issue.destroy
        flash[:notice] = "Issue '#{@issue.title}' deleted."
        redirect_to issues_path
    end
    
    def generate
        coder = HTMLEntities.new
        
        @issue = Issue.find(params[:id])
        @articles = @issue.articles.order(:order_number => :asc)
        
        @email_html = EmailHTML.new("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\">\n")
        
        @email_html.addline("<html>")
        @email_html.addline("")
        @email_html.addline("<body style='font-size: 10pt; font-family: Verdana,Geneva,sans-serif'>")
        @email_html.addline("    <table style='width: 100%;' border='0'>")
        @email_html.addline("        <tbody>")
        @email_html.addline("            <tr>")
        @email_html.addline("                <td style='background-color: #500000;'><span style='color: #ffffff; font-size: xx-large;'><strong>" + coder.encode(@issue.title, :named) + "</strong></span></td>")
        @email_html.addline("            </tr>")
        @email_html.addline("            <tr>")
        @email_html.addline("                <td style='background-color: #d3d3d3;'><em>The Graduate and Professional Student News Publication of Texas A&amp;M University</em><br />Volume " + @issue.volume.to_s + ", Issue " + @issue.issue_number.to_s + " |&nbsp;" + @issue.date.to_s + "</td>")
        @email_html.addline("            </tr>")
        @email_html.addline("        </tbody>")
        @email_html.addline("    </table>")
        @email_html.addline("    <p style='text-align: justify;'>&nbsp;<strong><span style='font-size: medium;'>Headlines at a Glance</span></strong></p>")
        @email_html.addline("    <ul>")
        
        #add headlines at a glance
        letter = "A"
        @articles.each do |article|
            @email_html.addline("        <li><a href='#" + letter + "'>" + coder.encode(article.title, :named) + " </a></li>")
            letter.next!
        end
        
        @email_html.addline("    </ul>")
        @email_html.addline("    <hr />")
        
        #add each article
        letter = "A"
        @articles.each do |article|
            @email_html.addline("")
            @email_html.addline("    <p style='text-align: justify;'><a name='" + letter + "'></a><span style='font-size: medium;'><strong>" + coder.encode(article.title, :named) + " </strong></span></p>")
            if (article.image_url.length > 0) 
                @email_html.addline("    <p style='text-align: justify;'><img style='float: left; margin-left: 5px; margin-right: 5px; border: 1px solid black; border-width: 1px;' src='" + article.image_url + "' alt='' width='400' height='225' /></p>")
            end
            
            paragraphs = article.content.split(/\n\n/)
            paragraphs.each do |paragraph|
                 @email_html.addline("    <p style='text-align: justify;'>" + coder.encode(paragraph, :named).gsub(/&lt;/, "<").gsub(/&gt;/, ">") + "</p>")
            end
            
            @email_html.addline("    <hr />")
            letter.next!
        end
        
        @email_html.addline("")
        @email_html.addline("    <p style='text-align: justify;'><a name='1'></a><span style='font-size: medium;'><strong>About the Nth Degree</strong></span><br />Nth Degree is an e-mail newsletter publication of the Graduate and Professional Student Council (GPSC). Founded in 2008, the newsletter serves as the source of news written by graduate and professional students, and delivered for graduate and professional students. Articles for the Nth Degree are welcome by students of the graduate and professional student council.</p>")
        @email_html.addline("    <p style='text-align: justify;'><img src='http://i.imgur.com/2fNvj2B.png' alt='' width='400' height='70' /><br />[ <a href='http://gpsc.tamu.edu'>Website</a> | <a href='https://www.facebook.com/gpsctamu/'>Facebook</a> | <a href='https://twitter.com/gpsctamu'>Twitter</a><a href='https://www.instagram.com/gpsctamu/'>Instagram</a> ]</p>")
        @email_html.addline("    <p style='text-align: justify;'><br /><span style='font-size: x-small;'>&copy;2016 Graduate and Professional Student Council. All rights reserved.</span><br /><span style='font-size: x-small;'>You are receiving this email because you are a graduate or professional student of Texas A&amp;M University.</span></p>")
        @email_html.addline("</body>")
        @email_html.addline("")
        @email_html.addline("</html>")
    end
end
