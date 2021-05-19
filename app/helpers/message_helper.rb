module MessageHelper

  def pattern_delete_confirm_message(pattern)
    project_count = pattern.projects.count
    shopping_item_count = pattern.shopping_items.count

    if project_count == 0
      "Are you sure you want to delete '#{pattern.title}'?"
    else
        "Are you sure you want to delete '#{pattern.title}'? It has #{project_count} #{'project'.pluralize(project_count)} and #{shopping_item_count} #{'shopping item'.pluralize(shopping_item_count)} attached which will also be deleted."
    end
  end   
end