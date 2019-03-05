module PageObjects
  module Images
    class ShowPage < PageObjects::Document
      path :image

      # collection :tag_elements, locator: '.js-image-tags', item_locator: '.js-tag-card'

      def image_url
        node.find('img')[:src]
      end

      def tags
        node.all('.js-tag-card').map(&:text).first.split
      end

      def delete
        node.click_on('Delete the image')
        yield node.driver.browser.switch_to.alert
      end

      def delete_and_confirm!
        node.click_on('Delete the image')
        node.driver.browser.switch_to.alert.accept
        window.change_to(IndexPage)
      end

      def go_back_to_index!
        node.click_on('Back to Home')
        window.change_to(IndexPage)
      end
    end
  end
end
