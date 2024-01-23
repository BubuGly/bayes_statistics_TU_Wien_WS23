// Hierarchical Model for Bill Length
data {
  int<lower=0> N; // Number of observations
  real bill_length[N]; // Response variable: bill length
  real bill_depth[N]; // Predictor variable: bill depth
  int<lower=1, upper=3> species[N]; // Species indicator variable (assuming three species)
  // Add other variables if needed
}

parameters {
  real alpha;      // Common intercept
  real beta_depth; // Common coefficient for bill depth
  real<lower=0> sigma; // Common standard deviation
  real alpha_species[3];   // Deviations from common intercept for each species
  real beta_depth_species[3];  // Deviations from common depth coefficient for each species
}

model {
  // Priors
  alpha ~ normal(0, 10);
  beta_depth ~ normal(0, 2);
  sigma ~ cauchy(0, 1);
  alpha_species ~ normal(0, 2);
  beta_depth_species ~ normal(0, 0.5);

  // Likelihood
  for (i in 1:N) {
    bill_length[i] ~ normal(alpha + alpha_species[species[i]] + beta_depth * bill_depth[i] + beta_depth_species[species[i]] * bill_depth[i], sigma);
  }
}
