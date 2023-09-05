import { ShieldsResponseSchema } from '@/app/api/_lib/shields-badges/dtos/shields-response.dto';
import { shieldsBadgesService } from '@/app/api/_lib/shields-badges/shields-badges.service';
import { exceptionRouteWrapper } from '@/app/api/exception-route-wrapper';
import { NextResponse } from 'next/server';

export const GET = exceptionRouteWrapper.wrapRoute<ShieldsResponseSchema>(() => {
	return NextResponse.json(shieldsBadgesService.getVersionBadge());
});
