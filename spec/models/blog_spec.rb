# spec/models/blog_spec.rb

if defined?(Blog)
  RSpec.describe Blog do
    shared_examples 'should merge the relation errors into errors' do
      it 'should merge the relation errors into errors' do
        instance.valid?

        expect(instance.errors.keys).to contain_exactly *errors.keys
        errors.each do |key, messages|
          expect(instance.errors[key]).to contain_exactly *messages
        end # each
      end # it
    end # shared_examples

    let(:instance) { Blog.new }

    ### Validation ###
    it { expect(instance).to be_valid }

    describe 'with a valid author' do
      let!(:author) { instance.author = Author.new :name => 'William Faulkner' }

      it { expect(instance).to be_valid }
    end # describe

    describe 'with an invalid author' do
      let!(:author) { instance.author = Author.new }
      let(:errors) do
        { :"author[name]" => ["can't be blank"] }
      end # let

      it { expect(instance).not_to be_valid }

      include_examples 'should merge the relation errors into errors'
    end # describe

    describe 'with many valid posts' do
      let!(:posts) { instance.posts = Array.new(3) { BlogPost.new :content => "You won't believe what this post does on live TV!"  } }

      it { expect(instance).to be_valid }
    end # describe

    describe 'with many invalid posts' do
      let!(:posts) { instance.posts = Array.new(3) { BlogPost.new } }
      let(:errors) do
        posts.each.with_index.with_object({}) do |(post, index), hsh|
          hsh[:"posts[#{index}][content]"] = ["can't be blank"]
        end # each
      end # let

      it { expect(instance).not_to be_valid }

      include_examples 'should merge the relation errors into errors'
    end # describe
  end # describe
end # if
