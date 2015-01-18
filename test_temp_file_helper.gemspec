# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'test_temp_file_helper/version'

Gem::Specification.new do |s|
  s.name          = "test_temp_file_helper"
  s.version       = TestTempFileHelper::VERSION
  s.authors       = ["Mike Bland"]
  s.email         = ["michael.bland@gsa.gov"]
  s.summary       = 'Class for managing temporary files in automated tests'
  s.description   = (
    'The TestTempFileHelper::TempFileHelper class manages the creation and ' +
    'cleanup of temporary files in automated tests.'
  )
  s.homepage      = 'https://github.com/18F/test_temp_file_helper'
  s.license       = 'CC0'

  s.files         = `git ls-files -z README.md lib`.split("\x0")

  s.add_runtime_dependency "rake", "~> 10.0"
  s.add_development_dependency "bundler", "~> 1.7"
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'codeclimate-test-reporter'
end
