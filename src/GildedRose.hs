module GildedRose where

type GildedRose = [Item]

-- an Item with name, sellIn and quality
data Item =
  Item String Int Int
  deriving (Eq)

instance Show Item where
  show (Item name sellIn quality) =
    name ++ ", " ++ show sellIn ++ ", " ++ show quality

updateQuality :: GildedRose -> GildedRose
updateQuality = map updateQualityItem

updateQualityItem :: Item -> Item
updateQualityItem item@(Item "Aged Brie" _ _)                                 = updateQualityCheese item
updateQualityItem item@(Item "Backstage passes to a TAFKAL80ETC concert" _ _) = updateQualityBackstagePasses item
updateQualityItem item@(Item "Sulfuras, Hand of Ragnaros" _ _)                = updateQualityLegendary item
updateQualityItem item                                                        = updateQualityRegular item

updateQualityCheese :: Item -> Item
updateQualityCheese (Item name sellIn quality) | sellIn' >= 0 = Item name sellIn' quality'
                                               | otherwise    = Item name sellIn' quality
  where
    quality' | quality < 50 = quality + 1
             | otherwise    = quality
    sellIn' = sellIn - 1


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
