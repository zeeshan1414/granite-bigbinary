import axios from "axios";

const show = () => axios.get("/preference");

const update = ({ payload }) => axios.put("/preference", payload);

const preferencesApi = {
  show,
  update
};

export default preferencesApi;
