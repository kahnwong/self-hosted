---
title: Easy
slug: /recipes
---
import Mermaid from '@theme/Mermaid';


## Potatoes
```
# baked
Three heads. Two hours. Don't Peel.

# mashed
- Three heads. Chopped. 1.30 hours. 
- 6 heads. Chopped. 2 hours
```

## Green chicken curry
<!-- ,color:#F4F8FA -->
<Mermaid chart={`
	flowchart TD;
        classDef steps stroke:#4a985a,stroke-width:6px
        classDef spices stroke:#336791,stroke-width:6px
        classDef ingredients stroke:#e09444,stroke-width:6px
        CoconutMilk1[Coconut Milk -  1/2 Cup];
        CoconutMilk2[Coconut Milk -  1 Cup];
        GreenCurryPaste[Green Curry Paste - 50 G];
        Chicken[Chicken - 100 G];
        Salt;
        Sugar;
        BasilLeaves[Basil Leaves - 1-2 Branches];
        ThaiEggplant[Thai Eggplant - 4 Units];
        LongRedPepper[Long Red Pepper - 1 Unit];
        CoconutMilk1-->|Pot|Boiling1([Boiling])-->Boiling2([Boiling]);
        GreenCurryPaste-->Boiling2;
        Boiling2-->Cooked1([Cooked]);
        Chicken-->Cooked1-->Boiling3([Boiling]);
        CoconutMilk2-->Boiling3-->Cooked2([Cooked]);
        Salt-->Cooked2;
        Sugar-->Cooked2;
        ThaiEggplant-->Cooked2-->Serve>Serve];
        BasilLeaves-->Serve;
        LongRedPepper-->Serve;
        class CoconutMilk1,CoconutMilk2,GreenCurryPaste,Chicken,BasilLeaves,ThaiEggplant,LongRedPepper ingredients;
        class Salt,Sugar spices;
        class Boiling1,Boiling2,Boiling3,Cooked1,Cooked2 steps;
`}/>


## Fried rice
<Mermaid chart={`
	flowchart TD;
        classDef steps stroke:#4a985a,stroke-width:6px
        classDef spices stroke:#336791,stroke-width:6px
        classDef ingredients stroke:#e09444,stroke-width:6px
		Oil-->|pan|Stir([Stir]);
		Garlic-->Stir;
		Shrimps-->Stir;
		Egg-->Stir-->Fry([Fry]);
		Rice-->Fry;
		OysterSauce-->Fry-->Serve>Serve];
        class Oil,Garlic,Shrimps,Egg,Rice,OysterSauce ingredients;
        class Salt,Sugar spices;
        class Stir,Fry steps;
`}/>

## Japanese rice hangover snack
<Mermaid chart={`
        flowchart TD;
        classDef steps stroke:#4a985a,stroke-width:6px
        classDef spices stroke:#336791,stroke-width:6px
        classDef ingredients stroke:#e09444,stroke-width:6px
        Egg-->|in the middle|Rice-->Microwave([Microwave])-->Stir([Stir]);
        SoySauce-->Stir
        class Rice,Egg ingredients;
        class SoySauce spices;
        class Microwave,Stir steps;
`}/>


## Chicken Harvest Salad
Yield: 4-6 servings

### Ingredients
- 4 slices bacon, cut into thirds
- 1 1/2 pounds boneless, skinless chicken thighs
- 2 teaspoons chopped fresh thyme leaves
- 1 teaspoon onion powder
- 1/2 teaspoon garlic powder
- 1 tablespoon canola oil
- Kosher salt freshly ground black pepper, to taste
- 1 large bunch kale, stems removed and leaves shredded
- 1 medium apple, thinly sliced
- 1 cup quartered fresh figs
- 1/2 cup sliced celery
- 1/2 cup roasted salted almonds, coarsely chopped
- 3 ounces goat cheese, crumbled

For the honey Dijon vinaigrette

- 1/3 cup extra virgin olive oil
- 2 tablespoons white wine vinegar
- 1 tablespoon Dijon mustard
- 2 teaspoons honey
- 1 teaspoon chopped fresh thyme leaves
- Kosher salt freshly ground black pepper, to taste

### Directions
1. In a medium bowl, whisk together olive oil, vinegar, Dijon, honey and thyme; season with salt and pepper, to taste. Set aside.
2. Heat a large skillet over medium high heat. Add bacon and cook until brown and crispy, about 6-8 minutes. Drain excess fat; transfer bacon to a paper towel-lined plate.
3. Preheat grill to medium heat. Season chicken with thyme, onion powder and garlic powder.
4. Brush chicken with canola oil; season with salt and pepper, to taste. Add chicken to grill, and cook, turning occasionally, until chicken is completely cooked through, reaching an internal temperature of 165 degrees F, about 10 minutes.
5. To assemble the salad, place kale in a large bowl; top with bacon, chicken, apple, figs, celery, almonds and goat cheese. Pour the honey Dijon vinaigrette on top of the salad and gently toss to combine.
6. Serve immediately.