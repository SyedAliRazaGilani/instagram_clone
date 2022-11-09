# frozen_string_literal: true

module ApplicationHelper

    def image(image, class_name= '')
        if image.attached?
            image_tag(image, height: 250, width: 180, class: class_name, style:"border-radius:5%") # remove inline styling.
        end
    end
end
