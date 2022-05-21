# Lecture Notes


## Linear SSIV - Exogenous Shares and Shocks
a weighted sum of a common set of shocks with weights reflecting heterogeneous exposure shares
- gn shocks vary at a different level than the zl does. 
- zl is an instrument for x 
- could also be where z = x (could just estimate the effects of z itself in a reduced form way)
- shares = L (purple)
- shocks vary at a different level "n" (orange)

What assumptions does the SSIV work? 
- AKA Bartik (1991) instrument also developed by Blanchard and Katz (1992)
- how much workers change their labor supply in response to changes in wages (local labor supply elasticity in commuting zones)
- labor demand - how many workers a firm wants to hire
- demand shock prediction to estimate the labor supply elasticity 
    - let's take the employment growth rate across the nation for each industry
        - we've then isolated demand because we've accounted for it at the aggregate level in the nation for an industry so we're left with the demand at a local demand shock for this industry
        - lagged shares of employment because some there is variation in industries demand for labor and when they need it (i think)
- See the Github folder for four paper examples of the origins of this instrument
    - From Intro slide set
    - Also look for Peter's paper in ReStat from this year for more micro examples
What does the IV estimated actually identify? 
    - Think about validity and relevance
    - You can check for relevance by running the first stage and making sure that the >>> is correlated with the treatment in large samples
    - Validity condition is a little different because we're not assuming i.i.d. sampling
        - Can't observe whether zl is not correlated with el (don't wan them correlated)
        - Have to ask what properties of shocks and shares make this condition hold? 
        - This zl is complicated because it is created from shares/shocks and probably won't be randomly assigned across l like a lottery....unlikely that zl=1 for some people and zl=0 for other kinda randomly. 
        - Can ask, "is it a natural experiment of a diff-in-diff?" 
First Approach - Thinking about it as NE
- What does it mean to have a natural experiment? 
    - AADHP, 2016: Exogenous Shocks in Industry-Level Regressions
        - ![[1653154874.png]]
        - Missed this part because I was setting up screenshot
        - need big enough sample - law of large numbers is approx. right. 
        - within sector theres randomness of which industry gets shock
        - Within this example, we wouldn't be comfortable with just running a regular regression (RCT ish)
            - We might be worried about spillovers in this example where different industries are getting some of the treatment effect
            - i.e. people moving across industries with negative employment shock. 
                - the trick is to then specify the outcome for local labor markets since people might leave an industry but they probably won't leave the boston metro
                - use the same shocks to different industries but measure the effects at the local labor market level (not industry level)
                    - this is the SSIV part
                    - local labor market will contain all of the spillovers we would expect from treatment at different level which would cause shocks at higher level
                    - we assume that these are commuter zones and won't spillover outside of it
        - Borusyak, Hull, and Jaravel 2022
            - assume that some industries have positive and some negative shocks randomly. 
                - zl and zk are not iid 
            - what is the estimator we are talking about? 
                - estimating beta controlling for w and instrumenting for x with z (with shares summing to 1)
                - reduced form of correlation / first stage correlation
                - produces sample residuals
                - ![[1653156227.png]]
                    - shift share IV estimator
                    - beta hat is the location level IV estimator
                    - need lots of different shocks because we rely on a shock-level law of large numbers (for consistency in large samples)
                    - qn is like a sector fixed effect 
                - we need conditional quasi-random assignment
                - weakly mutually correlated shocks
                - 

        
        
    
