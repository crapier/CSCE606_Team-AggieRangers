
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /^the nth Degree home page/
      issues_path
    when /^the Create New Issue page$/
      new_issue_path
    when /^the Issue (\d+) page$/
      issue_path($1.to_sym)
    when /^the Issue (\d+) edit page$/
      edit_issue_path($1.to_sym)
    when /^the Create New Article page for Issue (\d+)$/
      new_issue_article_path($1.to_sym)
    when /^the Article (\d+) page for Issue (\d+)$/
      issue_article_path($2.to_sym, $1.to_sym)
    when /^the edit Article (\d+) page for Issue (\d+)$/
      edit_issue_article_path($2.to_sym, $1.to_sym)
      

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
