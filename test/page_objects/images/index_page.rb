module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :images

      collection :images, locator: '.js-image-cards', item_locator: '.js-image-card', contains: ImageCard do
        def view!
          link = node.find('.js-image-link')
          link.click
          window.change_to(ShowPage)
        end
      end

      def add_new_image!
        node.click_on('Add new image')
        window.change_to(NewPage)
      end

      def showing_image?(url:, tags: nil)
        images.any? do |image|
          image.url == url &&
            ((tags.present? && image.tags == tags) || tags.nil?)
        end
      end

      def clear_tag_filter!
        node.click_on('Clear tag filter')
        window.change_to(IndexPage)
      end
    end
  end
end
