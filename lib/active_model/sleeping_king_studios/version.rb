# lib/active_model/sleeping_king_studios/version.rb

module ActiveModel
  # Hic Iacet Arthurus, Rex Quondam, Rexque Futurus.
  module SleepingKingStudios
    # @api private
    #
    # The current version of the gem.
    #
    # @see http://semver.org/
    module Version
      # Major version.
      MAJOR = 0
      # Minor version.
      MINOR = 0
      # Patch version.
      PATCH = 1
      # Prerelease version.
      PRERELEASE = 'alpha'
      # Build metadata.
      BUILD = 0

      # Generates the gem version string from the Version constants.
      def self.to_gem_version
        str = "#{MAJOR}.#{MINOR}.#{PATCH}"

        prerelease = self.const_defined?(:PRERELEASE) ? PRERELEASE : nil
        str << ".#{prerelease}" unless prerelease.nil? || (prerelease.respond_to?(:empty?) && prerelease.empty?)

        build = self.const_defined?(:BUILD) ? BUILD : nil
        str << ".#{build}" unless build.nil? || (build.respond_to?(:empty?) && build.empty?)

        str
      end # class method to_version
    end # module

    # The current version of the gem in rubygems-compatible format.
    VERSION = Version.to_gem_version
  end # module
end # module
