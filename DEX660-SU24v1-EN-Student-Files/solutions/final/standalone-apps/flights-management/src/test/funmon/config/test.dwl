/*-
 * #%L
 * MuleSoft Training - Anypoint Platform Development: Level 2
 * %%
 * Copyright (C) 2019 - 2023 MuleSoft, Inc. All rights reserved. http://www.mulesoft.com
 * %%
 * The software in this package is published under the terms of the
 * Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International Public License,
 * a copy of which has been included with this distribution in the LICENSE.txt file.
 * #L%
 */
%dw 2.0
---
config::common::main({}) ++ {
    env: "test",
    url: "https://tngaa-flights-management-test-37i9gq.d5n5q8.usa-e1.cloudhub.io"
}