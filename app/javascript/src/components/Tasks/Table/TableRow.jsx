import React from "react";

import PropTypes from "prop-types";

const TableRow = ({ data, destroyTask, showTask }) => {
  return (
    <tbody className="bg-white divide-y divide-gray-200">
      {data.map(rowData => (
        <tr key={rowData.id}>
          <td
            className="block w-64 px-6 py-4 text-sm font-medium
            leading-8 text-bb-purple capitalize truncate"
          >
            {rowData.title}
          </td>
          <td
            className="px-6 py-4 text-sm font-medium
            leading-5 text-gray-900 whitespace-no-wrap"
          >
            {rowData.assigned_user.name}
          </td>
          <td className="px-6 py-4 text-sm font-medium leading-5 text-right cursor-pointer">
            <a
              className="text-bb-purple"
              onClick={() => showTask(rowData.slug)}
            >
              Show
            </a>
          </td>
          <td
            className="px-6 py-4 text-sm font-medium
            leading-5 text-right cursor-pointer"
          >
            <a
              className="text-red-500
              hover:text-red-700"
              onClick={() => destroyTask(rowData.slug)}
            >
              Delete
            </a>
          </td>
        </tr>
      ))}
    </tbody>
  );
};

TableRow.propTypes = {
  data: PropTypes.array.isRequired,
  destroyTask: PropTypes.func,
  showTask: PropTypes.func
};

export default TableRow;
