package api.quickpizza;

import com.intuit.karate.junit5.Karate;

class PizzaSmokeRunner {

    @Karate.Test
    Karate testSmoke() {
        return Karate.run("classpath:api")
                .tags("@smoke");
    }
}
