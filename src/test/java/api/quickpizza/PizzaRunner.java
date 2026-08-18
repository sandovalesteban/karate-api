package api.quickpizza;

import com.intuit.karate.junit5.Karate;

class PizzaRunner {

    @Karate.Test
    Karate testAll() {
        return Karate.run("pizza").relativeTo(getClass());
    }

//    @Karate.Test
//    Karate testSmoke() {
//        return Karate.run("pizza").tags("@smoke").relativeTo(getClass());
//    }
}
