import React, { useState } from "react";

import PropTypes from "prop-types";

const Tooltip = ({ direction, content, delay, children }) => {
  const [active, setActive] = useState(false);
  let timeout;

  const showTip = () => {
    timeout = setTimeout(() => {
      setActive(true);
    }, delay || 400);
  };

  const hideTip = () => {
    clearInterval(timeout);
    setActive(false);
  };

  return (
    <div
      className="tooltip-wrapper"
      onMouseEnter={showTip}
      onMouseLeave={hideTip}
    >
      {children}
      {active && (
        <div className={`tooltip-tip ${direction || "top"}`}>{content}</div>
      )}
    </div>
  );
};

Tooltip.propTypes = {
  direction: PropTypes.oneOf(["top", "left", "bottom", "right"]),
  delay: PropTypes.number,
  content: PropTypes.node,
  children: PropTypes.node
};

export default Tooltip;
