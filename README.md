## test_temp_file_helper Gem

[![Gem Version](https://badge.fury.io/rb/test_temp_file_helper.svg)](https://badge.fury.io/rb/test_temp_file_helper)
[![Build Status](https://travis-ci.org/18F/test_temp_file_helper.svg?branch=master)](https://travis-ci.org/18F/test_temp_file_helper)
[![Code Climate](https://codeclimate.com/github/18F/test_temp_file_helper/badges/gpa.svg)](https://codeclimate.com/github/18F/test_temp_file_helper)
[![Test Coverage](https://codeclimate.com/github/18F/test_temp_file_helper/badges/coverage.svg)](https://codeclimate.com/github/18F/test_temp_file_helper)

The `TestTempFileHelper::TempFileHelper` class manages the creation and
cleanup of temporary files in automated tests.

Downloads and API docs are available on the [test_temp_file_helper RubyGems
page](https://rubygems.org/gems/test_temp_file_helper). API documentation is
written using [YARD markup](http://yardoc.org/).

Contributed by the 18F team, part of the United States General Services
Administration: https://18f.gsa.gov/

### Motivation

Rather than reimplement [Pyfakefs](http://code.google.com/p/pyfakefs) in Ruby,
in the short-term, I wrote this class to emulate Google's `TEST_DATADIR` and
`TEST_TMPDIR` convention instead, so that I could test code that works with
the file system.

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'test_temp_file_helper'
```

And then execute:
```
$ bundle
```

Or install it yourself as:
```
$ gem install test_temp_file_helper
```

### Usage

First, add the following to your `Rakefile`:

```ruby
require 'test_temp_file_helper/rake'

TestTempFileHelper::SetupTestEnvironmentTask.new do |t|
  t.base_dir = File.dirname __FILE__
  t.data_dir = File.join('test', 'data')
  t.tmp_dir = File.join('test', 'tmp')
end
```
The `SetupTestEnvironmentTask` properties:
- `base_dir`: parent directory used to set the environment variables
- `data_dir`: directory relative to `base_dir` used to set `TEST_DATADIR`
- `tmp_dir`: directory relative to `base_dir` used to set `TEST_TMPDIR`

If an environment variable is already set, or if the corresponding property is
not set on the +SetupTestEnvironmentTask+ object, the environment variable
will not be set or updated.

Then, create a `TempFileHelper` in your test's `setup` method, and call
`TempFileHelper.teardown` in your test's `teardown` method.

```ruby
class MyTest < ::Minitest::Test
  def setup
    @temp_file_helper = TestTempFileHelper::TempFileHelper.new
  end

  def teardown
    @temp_file_helper.teardown
  end

  def test_something_that_handles_files
    dir_path = @temp_file_helper.mkdir(File.join('path', 'to', 'dir'))
    file_path = @temp_file_helper.mkfile(File.join('path', 'to', 'file'))
    ...
  end
end
```

### Contributing

1. Fork the repo ( https://github.com/18F/test_temp_file_helper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Feel free to ping [@mbland](https://github.com/mbland) with any questions you
may have, especially if the current documentation should've addressed your
needs, but didn't.

### Public domain

This project is in the worldwide [public domain](LICENSE.md). As stated in
[CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright
> and related rights in the work worldwide are waived through the
> [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication.
> By submitting a pull request, you are agreeing to comply with this waiver of
> copyright interest.
