import React from 'react';
import { SvgIcon, SvgIconProps } from '@material-ui/core';
import { ReactComponent as ProfitIcon } from './images/profit.svg';

export default function Keys(props: SvgIconProps) {
  return <SvgIcon component={ProfitIcon} viewBox="0 0 58 58" {...props} />;
}
