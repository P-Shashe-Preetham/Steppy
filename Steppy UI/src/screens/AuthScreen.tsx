import React, { useState } from "react";
import { useApp } from "../context/AppContext";

export function AuthScreen() {
  const { login, signup, showToast } = useApp();
  const [isSignUp, setIsSignUp] = useState(false);
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!email || !password || (isSignUp && !name)) {
      showToast("Please fill in all fields.");
      return;
    }

    setIsLoading(true);
    setTimeout(() => {
      if (isSignUp) {
        signup(name, email, password);
      } else {
        login(email, password);
      }
      setIsLoading(false);
    }, 400);
  };

  const handleDemoLogin = () => {
    login("honeybadger@steppy.app", "password123");
  };

  return (
    <div className="auth-container">
      <div className="auth-card">
        {/* Logo & Branding */}
        <div className="auth-logo-badge">
          <span>👟</span>
        </div>
        <h1 className="auth-title">Steppy</h1>
        <p className="auth-subtitle">
          Turn your daily steps into real rewards & level up with friends.
        </p>

        {/* Tab Toggle */}
        <div className="auth-tabs">
          <button
            type="button"
            className={`auth-tab ${!isSignUp ? "active" : ""}`}
            onClick={() => setIsSignUp(false)}
          >
            Sign In
          </button>
          <button
            type="button"
            className={`auth-tab ${isSignUp ? "active" : ""}`}
            onClick={() => setIsSignUp(true)}
          >
            Create Account
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="auth-form">
          {isSignUp && (
            <div className="auth-field">
              <label>Full Name</label>
              <input
                type="text"
                placeholder="Alex Morgan"
                value={name}
                onChange={(e) => setName(e.target.value)}
                required
              />
            </div>
          )}

          <div className="auth-field">
            <label>Email Address</label>
            <input
              type="email"
              placeholder="alex@fitness.com"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
          </div>

          <div className="auth-field">
            <label>Password</label>
            <input
              type="password"
              placeholder="••••••••"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
          </div>

          <button type="submit" className="auth-submit-btn" disabled={isLoading}>
            {isLoading ? "Signing in..." : isSignUp ? "Create My Account" : "Sign In to Steppy"}
          </button>
        </form>

        <div className="auth-divider">
          <span>OR</span>
        </div>

        {/* Quick Demo Access Button */}
        <button
          type="button"
          onClick={handleDemoLogin}
          className="auth-demo-btn"
        >
          🚀 Instant Demo Login (Level 4 · 420 🪙)
        </button>

        <p className="auth-footer-text">
          {isSignUp ? (
            <>
              Already have an account?{" "}
              <button
                type="button"
                className="auth-link"
                onClick={() => setIsSignUp(false)}
              >
                Sign In
              </button>
            </>
          ) : (
            <>
              New to Steppy?{" "}
              <button
                type="button"
                className="auth-link"
                onClick={() => setIsSignUp(true)}
              >
                Sign Up (+100 Free Coins)
              </button>
            </>
          )}
        </p>
      </div>
    </div>
  );
}
