// Separate Model for Bill Length
data {
  int<lower=0> N; // Number of observations
  real bill_length[N]; // Response variable: bill length
  real bill_depth[N]; // Predictor variable: bill depth
  int<lower=1, upper=3> species[N]; // Species indicator variable (assuming three species)
  // Add other variables if needed
}

parameters {
  real alpha[3];   // Intercept for each species
  real beta_depth[3];  // Coefficient for bill depth for each species
  real<lower=0> sigma; // Common standard deviation
}

model {
  // Priors
  alpha ~ normal(0, 10);
  beta_depth ~ normal(0, 2);
  sigma ~ cauchy(0, 1);

  // Likelihood
  for (i in 1:N) {
    bill_length[i] ~ normal(alpha[species[i]] + beta_depth[species[i]] * bill_depth[i], sigma);
  }
}
