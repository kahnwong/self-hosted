```mermaid
flowchart TD;
        classDef steps stroke:#4a985a,stroke-width:6px,color:#F4F8FA
        classDef spices stroke:#336791,stroke-width:6px,color:#F4F8FA
        classDef ingredients stroke:#e09444,stroke-width:6px,color:#F4F8FA
        Egg-->|in the middle|Rice-->Microwave([Microwave])-->Stir([Stir]);
        SoySauce-->Stir
        class Rice,Egg ingredients;
        class SoySauce spices;
        class Microwave,Stir steps;




        ```