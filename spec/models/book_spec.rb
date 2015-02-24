# spec/models/book_spec.rb

require 'spec_helper'

if defined?(Book)
  RSpec.describe Book do
    shared_examples 'should merge the relation errors into errors' do
      it 'should merge the relation errors into errors' do
        instance.valid?

        expect(instance.errors.keys).to contain_exactly *errors.keys
        errors.each do |key, messages|
          expect(instance.errors[key]).to contain_exactly *messages
        end # each
      end # it
    end # shared_examples

    let(:instance) { Book.new }

    ### Validation ###
    it { expect(instance).to be_valid }

    describe 'with a valid preface' do
      let!(:preface) { instance.preface = BookPreface.new :content => "I'd like to thank my fans for this opportunity..." }

      it { expect(instance).to be_valid }
    end # describe

    describe 'with an invalid preface' do
      let!(:preface) { instance.preface = BookPreface.new }
      let(:errors) do
        { :"preface[content]" => ["can't be blank"] }
      end # let

      it { expect(instance).not_to be_valid }

      include_examples 'should merge the relation errors into errors'
    end # describe

    describe 'with many valid chapters' do
      let!(:chapters) { instance.chapters = Array.new(3) { BookChapter.new :content => 'It was the best of times, it was the worst of times...'  } }

      it { expect(instance).to be_valid }
    end # describe

    describe 'with many invalid chapters' do
      let!(:chapters) { instance.chapters = Array.new(3) { BookChapter.new } }
      let(:errors) do
        chapters.each.with_index.with_object({}) do |(post, index), hsh|
          hsh[:"chapters[#{index}][content]"] = ["can't be blank"]
        end # each
      end # let

      it { expect(instance).not_to be_valid }

      include_examples 'should merge the relation errors into errors'
    end # describe
  end # describe
end # if
