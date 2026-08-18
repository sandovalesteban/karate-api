package api.quickpizza;

import com.intuit.karate.junit5.Karate;

class PizzaRunner {

    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:api");
    }

}
