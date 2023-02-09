# frozen_string_literal: true

module Polaris
  class ThumbnailComponent < Polaris::Component
    SIZE_DEFAULT = :medium
    SIZE_MAPPINGS = {
      small: "Polaris-Thumbnail--sizeSmall",
      medium: "Polaris-Thumbnail--sizeMedium",
      large: "Polaris-Thumbnail--sizeLarge"
    }
    SIZE_OPTIONS = SIZE_MAPPINGS.keys

    renders_one :icon, Polaris::IconComponent

    def initialize(
      alt: nil,
      size: SIZE_DEFAULT,
      source: nil,
      transparent: false,
      **system_arguments
    )
      @alt = alt
      @source = source
      @transparent = transparent

      @system_arguments = system_arguments
    end

    def renders?
      source.present? || icon.present?
    end

    def system_arguments
      @system_arguments.tap do |opts|
        opts[:tag] = :span
        opts[:classes] = class_names(
          @system_arguments[:classes],
          "Polaris-Thumbnail",
          SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, SIZE_DEFAULT)],
          "Polaris-Thumbnail--transparent": @transparent
        )
      end
    end
  end
end
