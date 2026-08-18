package api.quickpizza;

import com.intuit.karate.junit5.Karate;

class PizzaSmokeRunner {

    @Karate.Test
    Karate testSmoke() {
        return Karate.run("pizza")
                .tags("@smoke")
                .relativeTo(getClass());
    }
}
