module ActionDispatch
  module Routing
    class Mapper
     module Resources
        class Resource
          def default_actions
            if @api_only
              [:index, :create, :show, :update, :destroy,:csv_export]
            else
              [:index, :create, :new, :show, :update, :destroy,:csv_export, :edit ]
            end
          end
        end
        def resources(*resources, &block)
          options = resources.extract_options!.dup

          if apply_common_behavior_for(:resources, resources, options, &block)
            return self
          end

          with_scope_level(:resources) do
            options = apply_action_options options
            resource_scope(Resource.new(resources.pop, api_only?, @scope[:shallow], options)) do
              yield if block_given?

              concerns(options[:concerns]) if options[:concerns]

              collection do
                get  :index if parent_resource.actions.include?(:index)
                get  :csv_export if parent_resource.actions.include?(:csv_export)
                post :create if parent_resource.actions.include?(:create)
              end

              new do
                get :new
              end if parent_resource.actions.include?(:new)

              set_member_mappings_for_resource
            end
          end

          self
        end
       end
      end
    end
  end
