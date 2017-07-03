module TaoUi
  module Components
    module Table

      class BaseBuilder

        attr_reader :view, :options, :expandable, :selectable

        def initialize view, options = {}
          @view = view
          @options = options
          @expandable = options[:expandable].presence || false
          @selectable = options[:selectable].presence || false
        end

        def merge_options options, other_options
          options.merge(other_options) { |key, old_val, new_val|
            if key.to_s == 'class'
              old_val = old_val.split(' ') if old_val.is_a? String
              new_val = new_val.split(' ') if new_val.is_a? String
              Array(old_val) + Array(new_val)
            elsif old_val.is_a?(Hash) && old_val.is_a?(Hash)
              old_val.merge! new_val
            else
              new_val
            end
          }
        end

        protected

        def expandable_th
          @expandable_th ||= view.content_tag 'th', nil, class: 'th-expand-icon'
        end

        def selectable_th
          @selectable_th ||= view.content_tag 'th', class: 'th-checkbox' do
            view.tao_check_box
          end
        end

        def expandable_td
          @expandable_td ||= view.content_tag 'td', class: 'td-expand-icon' do
            view.tao_icon :arrow_right
          end
        end

        def selectable_td
          @selectable_td ||= view.content_tag 'td', class: 'td-checkbox' do
            view.tao_check_box
          end
        end

      end

    end
  end
end
