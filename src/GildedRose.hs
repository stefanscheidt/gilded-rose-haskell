module GildedRose where

type GildedRose = [Item]

data Item = Item String Int Int
  deriving (Eq)

instance Show Item where
  show (Item name sellIn quality) =
    name ++ ", " ++ show sellIn ++ ", " ++ show quality

updateQuality :: GildedRose -> GildedRose
updateQuality = map updateQualityItem

updateQualityItem :: Item -> Item
updateQualityItem item@(Item name sellIn quality) =
  if name == "Aged Brie"
  then
    updateQualityCheese item
  else if name == "Backstage passes to a TAFKAL80ETC concert"
  then
    updateQualityBackstagePasses item
  else if name == "Sulfuras, Hand of Ragnaros"
  then
    updateQualityLegendary item
  else
    updateQualityRegular item

updateQualityCheese :: Item -> Item
updateQualityCheese (Item name sellIn quality) =
  let
    quality' | quality < 50 = quality + 1
             | otherwise    = quality
    sellIn' = sellIn - 1      
  in
    if sellIn' < 0
      then
          if quality' < 50
          then (Item name sellIn' (quality' + 1))
          else (Item name sellIn' quality)
      else (Item name sellIn' quality')

updateQualityBackstagePasses :: Item -> Item
updateQualityBackstagePasses (Item name sellIn quality) =
  let
    quality' =
      if quality < 50
        then
          quality + 1 +
              if sellIn < 11
              then
                if quality < 49
                then
                  1 + (if sellIn < 6
                        then
                          if quality < 48
                          then 1
                          else 0
                        else 0)
                else 0
              else 0
        else quality

    sellIn' = sellIn - 1
  in
    if sellIn' < 0
    then (Item name sellIn' 0)
    else (Item name sellIn' quality')

updateQualityLegendary :: Item -> Item
updateQualityLegendary item = item

updateQualityRegular :: Item -> Item
updateQualityRegular (Item name sellIn quality) =
  let
    quality' | quality > 0 = quality - 1
             | otherwise   = quality
    sellIn' = sellIn - 1
  in
    if sellIn' < 0
    then
      if quality' > 0
      then
        (Item name sellIn' (quality' - 1))
      else (Item name sellIn' quality')
    else (Item name sellIn' quality')
