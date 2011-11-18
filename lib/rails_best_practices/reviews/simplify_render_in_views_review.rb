# encoding: utf-8
require 'rails_best_practices/reviews/review'

module RailsBestPractices
  module Reviews
    # Review a view file to make sure using simplified syntax for render.
    #
    # See the best practice details here http://rails-bestpractices.com/posts/61-simplify-render-in-views.
    #
    # Implementation:
    #
    # Review process:
    #   check all render method commands in view files,
    #   if there is a key 'partial' in the argument, then they should be replaced by simplified syntax.
    class SimplifyRenderInViewsReview < Review
      interesting_nodes :command
      interesting_files VIEW_FILES

      def url
        "http://rails-bestpractices.com/posts/61-simplify-render-in-views"
      end

      # check command node in view file,
      # if its message is render and the arguments contain a key partial,
      # then it should be replaced by simplified syntax.
      def start_command(node)
        if "render" == node.message.to_s
          hash_node =  node.arguments.all[0]
          if hash_node && :bare_assoc_hash == hash_node.sexp_type &&
            hash_node.hash_keys.include?("partial") &&
            !hash_node.hash_value("partial").to_s.include?('/')
            add_error 'simplify render in views'
          end
        end
      end
    end
  end
end
