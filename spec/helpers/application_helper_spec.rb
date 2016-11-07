require 'rails_helper'


describe "ApplicationHelper" do
    include ApplicationHelper

    it "Should return a proper bootstrap class" do
        expect(bootstrap_class_for("success")).to eq("alert-success");
        expect(bootstrap_class_for("doesnotexist")).to eq("doesnotexist");
    end   
    
    it "Should return nil" do
        flash[:sucess] = "Some message"
        expect(flash_messages).to eq(nil);
    end 
    
    
end
