module GildedRoseSpec (spec) where

import Test.Hspec
import GildedRose

spec :: Spec
spec =
  describe "updateQuality" $ do

    it "decrements sellIn and quality" $
      let inventory = [Item "item" 10 10]
          actual = updateQuality inventory
          expected = [Item "item" 9 9]
      in actual `shouldBe` expected

    it "never decrements quality below zero" $
      let inventory = [Item "item" 10 0]
          actual = updateQuality inventory
          expected = [Item "item" 9 0]
      in actual `shouldBe` expected

    it "decrements quality twice after sellIn passed" $
      let inventory = [Item "item" 0 10]
          actual = updateQuality inventory
          expected = [Item "item" (-1) 8]
      in actual `shouldBe` expected

    it "decrement quality twice honors quality being non negative" $
      let inventory = [Item "item" 0 1]
          actual = updateQuality inventory
          expected = [Item "item" (-1) 0]
      in actual `shouldBe` expected
