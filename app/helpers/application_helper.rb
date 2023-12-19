module ApplicationHelper
  def full_title(extra_title = '')
    base_title = 'Conduit'
    if extra_title.empty?
      base_title
    else
      extra_title + " ― " + base_title
    end
  end
end
