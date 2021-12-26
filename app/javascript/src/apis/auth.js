import axios from "axios";

const login = payload => axios.post("/session", payload);

const logout = () => axios.delete(`/session`);

const signup = payload => axios.post("/users", payload);

const authApi = {
  login,
  logout,
  signup
};

export default authApi;
