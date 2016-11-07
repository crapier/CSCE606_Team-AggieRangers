
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
      id = Issue.all[$1.to_i - 1].id
      issue_path(id)
    when /^the Issue (\d+) edit page$/
      id = Issue.all[$1.to_i - 1].id
      edit_issue_path(id)
    when /^the Issue (\d+) generate page$/
      id = Issue.all[$1.to_i - 1].id
      generate_issue_path(id)
    when /^the Create New Article page for Issue (\d+)$/
      id = Issue.all[$1.to_i - 1].id
      new_issue_article_path(id)
    when /^the Article (\d+) page for Issue (\d+)$/
      id = Issue.all[$1.to_i - 1].id
      id_a = Issue.find(id).articles[$2.to_i - 1].id
      issue_article_path(id, id_a)
    when /^the edit Article (\d+) page for Issue (\d+)$/
      id = Issue.all[$1.to_i - 1].id
      id_a = Issue.find(id).articles[$2.to_i - 1].id
      edit_issue_article_path(id, id_a)
      

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
