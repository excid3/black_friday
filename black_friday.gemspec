# frozen_string_literal: true

require_relative "lib/black_friday/version"

Gem::Specification.new do |spec|
  spec.name = "black_friday"
  spec.version = BlackFriday::VERSION
  spec.authors = ["Chris Oliver"]
  spec.email = ["excid3@gmail.com"]

  spec.summary = "Black Friday sales in your Rails apps"
  spec.description = "Black Friday sales in your Rails apps"
  spec.homepage = "https://github.com/excid3/black_friday"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage + "/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
end
